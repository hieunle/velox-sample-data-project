"""dwh_nightly, the Python half of the nightly load (pg_cron runs the SQL half).

Reads config/connections.ini, lands the SAP flat files from /mnt/erp_export into the sales and
supply tables with COPY, then calls the procedures in order. Runs on the ETL box ETL02 under the
service account svc_dwh_etl at 01:00; a failed step pages the on-call DBA.
"""
import configparser
import sys
from pathlib import Path

import psycopg

CFG = configparser.ConfigParser()
CFG.read(Path(__file__).resolve().parents[2] / "config" / "connections.ini")
DWH = CFG["dwh"]

STEPS = [
    ("sales.orderline", "sap_vbap_*.csv"),
    ("sales.salesorder", "sap_vbak_*.csv"),
    ("supply.purchaseorder", "sap_ekko_*.csv"),
    ("supply.shipment", "sap_likp_*.csv"),
]
PROCS = [
    "CALL mfg.sp_load_productionrun()",
    "CALL sales.sp_build_invoice(%s)",
    "CALL supply.sp_snapshot_inventory(%s)",
]


def connect():
    return psycopg.connect(
        host=DWH["host"], port=DWH["port"], dbname=DWH["dbname"], user=DWH["user"],
        password=Path("/etc/dwh/.pw").read_text().strip(), sslmode=DWH["sslmode"],
    )


def land(cn, table, pattern):
    for f in sorted(Path(CFG["erp"]["path"]).glob(pattern)):
        with cn.cursor().copy(f"COPY {table} FROM STDIN WITH (FORMAT csv, HEADER true)") as copy, open(f, "rb") as src:
            while chunk := src.read(1 << 20):
                copy.write(chunk)


def main(date_key: int):
    with connect() as cn:
        for table, pattern in STEPS:
            land(cn, table, pattern)
        cur = cn.cursor()
        cur.execute(PROCS[0])
        cur.execute(PROCS[1], (date_key,))
        cur.execute(PROCS[2], (date_key,))
        cn.commit()


if __name__ == "__main__":
    main(int(sys.argv[1]))

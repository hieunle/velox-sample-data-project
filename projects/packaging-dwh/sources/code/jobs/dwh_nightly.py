"""DWH_Nightly, the Python half of the nightly load (SQL Agent runs the T-SQL half).

Reads config/connections.ini, lands the SAP flat files from \\fs01\erp_export into the sales and
supply staging tables with bcp, then calls the procedures in order. Runs on the ETL box ETL02
under the service account svc_dwh_etl at 01:00; a failed step pages the on-call DBA.
"""
import configparser
import subprocess
import sys
from pathlib import Path

import pyodbc

CFG = configparser.ConfigParser()
CFG.read(Path(__file__).resolve().parents[2] / "config" / "connections.ini")
DWH = CFG["dwh"]

STEPS = [
    ("sales.OrderLine", "sap_vbap_*.csv"),
    ("sales.SalesOrder", "sap_vbak_*.csv"),
    ("supply.PurchaseOrder", "sap_ekko_*.csv"),
    ("supply.Shipment", "sap_likp_*.csv"),
]
PROCS = [
    "EXEC mfg.sp_Load_ProductionRun",
    "EXEC sales.sp_Build_Invoice @OrderDateKey = ?",
    "EXEC supply.sp_Snapshot_Inventory @SnapshotDateKey = ?",
]


def connect():
    return pyodbc.connect(
        f"DRIVER={{{DWH['driver']}}};SERVER={DWH['server']};DATABASE={DWH['database']};"
        f"UID={DWH['user']};PWD={Path('/etc/dwh/.pw').read_text().strip()};"
        f"Encrypt={DWH['encrypt']};TrustServerCertificate={DWH['trust_server_certificate']}"
    )


def land(table, pattern):
    for f in sorted(Path(CFG["erp"]["path"]).glob(pattern)):
        subprocess.run(["bcp", table, "in", str(f), "-S", DWH["server"], "-d", DWH["database"], "-c", "-t,", "-F", "2"], check=True)


def main(date_key: int):
    for table, pattern in STEPS:
        land(table, pattern)
    with connect() as cn:
        cur = cn.cursor()
        cur.execute(PROCS[0])
        cur.execute(PROCS[1], date_key)
        cur.execute(PROCS[2], date_key)
        cn.commit()


if __name__ == "__main__":
    main(int(sys.argv[1]))

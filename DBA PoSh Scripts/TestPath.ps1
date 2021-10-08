If (Test-DbaPath -SqlInstance 000-srv-db1 -EnableException -Path \\000-idpa-dd1.pharmaca.com\db1-backups) {
    "This is a valid path."
}
Else {
    Throw [invalidoperationexception]
}
    
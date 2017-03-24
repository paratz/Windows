#Change CRL publication period, for example to 5 days

certutil -setreg CA\CRLPeriodUnits 5
certutil -setreg CA\CRLPeriod "Days"
certutil -setreg CA\CRLDeltaPeriodUnits 5
certutil -setreg CA\CRLDeltaPeriod "Days"

#Restart Certification Authority Services
restart-service CertSvc

#republish CRL from the CA administration console, right click revoked certs, all taks, publish
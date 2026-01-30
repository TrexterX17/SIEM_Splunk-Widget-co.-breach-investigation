-- Figure 8: Malicious VPN Activity
-- Purpose: Detect suspicious VPN logins tied to attacker IP or compromised users

index=final_project sourcetype=vpn
| search src_ip=180.76.54.93 OR user IN ("BDRVLS","DDDXUB")
| table _time user src_ip location status
| sort _time

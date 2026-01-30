-- Figure 5: Lateral Movement Using DDDXUB Credentials
-- Purpose: Identify privilege escalation and unauthorized access

index=final_project user=DDDXUB
| search status="success"
| table _time user src_ip sourcetype application
| sort _time

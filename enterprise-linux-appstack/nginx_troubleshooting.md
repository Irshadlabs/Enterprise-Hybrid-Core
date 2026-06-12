# Enterprise Nginx Web Server Troubleshooting Playbook
**Classification:** Operational Runbook  
**Author:** Mohammed Irshad (Cloud & Network Support Engineer)

---

## Case Study 1: Resolving `502 Bad Gateway` Error
* **Symptom:** Users receive a 502 error when accessing the domain.
* **Root Cause:** Nginx cannot establish a socket connection with the backend application running on port 8080.
* **Triage & Resolution CLI Commands:**
```bash
  # 1. Check if the backend process (Node/Python/Java) is active and bound to port 8080
  ss -tlnp | grep 8080

  # 2. Check Nginx upstream error log vector for connection refused traces
  tail -n 50 /var/log/nginx/app_error.log

  # 3. Verify SELinux policy configurations (if blocking internal network connections)
  getsebool httpd_can_network_connect
  # If off, flip it to active:
  setsebool -P httpd_can_network_connect 

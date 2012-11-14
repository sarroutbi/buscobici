#!/bin/bash
# Remember: This can be done becahse a .pgpass must exist on 
# HOME dir, with permission 0600, containing the password
psql --user postgres -h 192.168.0.40 bikesearch -c "DELETE FROM bikes WHERE store LIKE 'TomasDomingo';"

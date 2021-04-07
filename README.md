# IITG-Autologin
A (BA)SH script for automating the IITG internet access login portal for a smooth browsing experience inside the campus.

In login.sh / test.sh, set username and password to your IITG login credentials.
# For normal use
Download and place all the files in the Normal sub-folder in their respective paths in the Linux directory structure. The login.sh script has to placed in the root directory since absolute paths are used. Make sure to tweak the script and the cron file if it is being run from a different location.

>key contains the keepalive URL to be refreshed.
>log is a log file of all the keepalive URLs received. Under optimal conditions URL changes are rare. Only a handful of entries are expected in a college semester.
  
# For diagnostics
Download and place all the files in the Logged sub-folder in their repesctive paths in the Linux directory structure. The test.sh script has to placed in the root directory since absolute paths are used. Make sure to tweak the script and the cron file if it is being run from a different location. After normal connectivity is restored, change 'test.sh' in etc/crontabs/root to 'login.sh' and delete the second line in the file. 
>count contains the total number of times the refresh failed today.
>daily_log has the number of failed refreshes per day.
>fail contains the exact times when the refresh failed. It may be necessary to clear this file often (with a cron entry) on very low memory devices.
>fcount contains a non-zero value if the script failed on the latest run. The number refers to the prior consecutive failures.

It is recommended to run the normal script once every 10 minutes using a cron script, the logged script can be run as often as every minute. It is not recommended since we do not know the capabilities of the servers.

Edit etc/crontabs/root and add "*/10 * * * * /bin/sh /root/login.sh" (No "").
You will need to restart cron with one of the following commands depending on the distro.

/etc/init.d/crond restart

/etc/init.d/cron restart

For a truly hassle-free internet experience at IITG, the script can be run on a WIFI router. I am unaware of any brands that allow running script natively in their operating systems, therefore it will be necessary to install a router focused Linux distribution like DD-WRT or OpenWrt. Precompiled up-to-date builds are available for most common brands and models. Curl and other dependencies will have to be installed separately. It is paramount to match the whole model number since manufactures may use different processors for different regions. Devices with Realtek processors are poorly supported, so a few of the most budget options might not be viable for this purpose. Installing such an OS also provides many other features like network-level ad-blocking or VPN and things like SQM that might improve streaming and gaming performance significantly.

Because of a feature called DNS rebind protection https://agnigarh.iitg.ac.in:1442/login? might not resolve correctly, using https://192.168.193.1:1442/login? will still work. The feature can be turned off in the DHCP section of the router to fix the issue.

The script is not for Windows, you can still run it on android or iOS :D

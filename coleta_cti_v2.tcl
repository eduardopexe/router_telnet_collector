#!/usr/bin/expect -f

#  set logpath "/coleta_crc/coleta_cti/"

#set linha [split $argv :]
  set logpath "/usr/coleta_crc/log/[lindex $argv 2]"
  log_user 1
match_max 100000  
  #####Password e Enable Password
  set pass "ps0417"
  set enapass "600xpsys"
  ##############################################################################
  set data [exec date +%Y%m%d]
  
   
   log_file "$logpath/[lindex $argv 0]-[lindex $argv 1]-[lindex $argv 3]-.txt"
   spawn telnet "[lindex $argv 0]\n"
   set timeout 20
   expect {
           "name:" {
	   send "$pass\n"
	   expect "word:"
           send "$enapass\n"
	   expect { 
	   ">" {
	   send "term len 0\n"
	   expect ">"
	   send "show int\nshow controllers E1\n"
	   expect "[lindex $argv 1]>"
	   send "\nexit\n"
    #      expect ">"
    #      send "exit\n"
	   }
	   "name:" {
	   send "offline\r"
	   expect "word:"
           send "1485primesys\r"
	   expect ">"
	   send "term len 0\r"
	   expect ">"
	   send "sh ip int bri | inc Gig\rshow int\r"
	   expect ">"
	   send "show version\r"
	   expect ">"
	   send "exit\r"
           expect ">"
           send "exit\r"	   
	   }
	   
	   }
           #expect ">"
           #send "exit\r"	   
	   }
	   "word:" {
	   send "Primesys600X\r1485primesys\r"
	   expect { 
	   ">" {
	   send "term len 0\r"
	   expect ">"
	   send "sh ip int bri | inc Gig\rshow int\r"
	   expect ">"
           send "exit\r"
           expect ">"
           send "exit\r"
           #expect ">"
           #send "exit\r"           
	   }
	   "word:" {
	   send "cisco\r"
	   expect ">"
	   send "term len 0\r"
	   expect ">"
	   send "sh ip int bri | inc Gig\rshow int\r"
	   expect ">"
           send "exit\r"
           expect ">"
           send "exit\r"
	   #expect ">"
           #send "exit\r"
           }
	   "word:" {
	   send "prime1485sys\r"
	   expect ">"
	   send "term len 0\r"
	   expect ">"
	   send "show controllers E1 | inc E1\rshow int\r"
	   expect ">"
	   send "show version\r"
	   expect ">"
           send "exit\r"
           expect ">"
           send "exit\r"
	   #expect ">"
           #send "exit\r"
           }
	   }
	   }
	   
   }
     
#xpect ">"
#send "exit\n"
set timeout 10 
   expect "tralia"
#expect ">"
#send "exit\n"   
   log_file	  

exit

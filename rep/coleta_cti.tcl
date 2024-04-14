#!/usr/bin/expect -f

#  set logpath "/coleta_crc/coleta_cti/"

set linha [split $argv :]
  set logpath "/coleta_crc/log/[lindex $linha 2]"
  log_user 1
  
  #####Password e Enable Password
  set pass "ps0417"
  set enapass "1910co"
  ##############################################################################
  set timeout 20
  set data [exec date +%Y%m%d]
  
   
   log_file "$logpath/[lindex $linha 0]-[lindex $linha 1]-.$data"
   spawn telnet "[lindex $linha 0]\r"
   set timeout 30
   expect {
           "name:" {
	   send "$pass\r"
	   expect "word:"
           send "$enapass\r"
	   expect { 
	   ">" {
	   send "term len 0\r"
	   expect ">"
	   send "sh ip int bri | inc Gig\rshow int\r"
	   expect ">"
	   send "exit\r"
           expect ">"
           send "exit\r"
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
     
expect ">"
send "quit\r"
#expect ">"
#send "quit\r"
#expect "#"
#send "\n"   
   set timeout 20
   expect "tralia"
   
   log_file	  

#exit

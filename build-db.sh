#/bin/bash
sed -e '
s/\/\/wbu.wpengine.com/\/\/wbu.test/g;
s/wbu.wpengine.com/wbu.test/g;
s/\/nas\/content\/staging\/wbu/\/srv\/www\/wbu\/public_html/g;
s/www.theevergrey.com/seattle.wbu.test/g;
s/theevergrey.com/seattle.wbu.test/g;
s/www.thenewtropic.com/miami.wbu.test/g;
s/thenewtropic.com/miami.wbu.test/g
' mysql.sql > dev_mysql.sql
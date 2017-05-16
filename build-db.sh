#/bin/bash
sed -e '
s/\/\/wbu.wpengine.com/\/\/wbu.dev/g;
s/wbu.wpengine.com/wbu.dev/g;
s/\/nas\/content\/staging\/wbu/\/srv\/www\/wbu\/public_html/g;
s/www.theevergrey.com/seattle.wbu.dev/g;
s/theevergrey.com/seattle.wbu.dev/g;
s/www.thenewtropic.com/miami.wbu.dev/g;
s/thenewtropic.com/miami.wbu.dev/g
' mysql.sql > dev_mysql.sql
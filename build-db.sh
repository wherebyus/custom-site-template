#/bin/bash
sed -e '
s/\/\/wbu.wpengine.com/\/\/wbu.site/g;
s/wbu.wpengine.com/wbu.site/g;
s/\/nas\/content\/staging\/wbu/\/srv\/www\/wbu\/public_html/g;
s/www.theevergrey.com/seattle.wbu.site/g;
s/theevergrey.com/seattle.wbu.site/g;
s/www.thenewtropic.com/miami.wbu.site/g;
s/thenewtropic.com/miami.wbu.site/g
' mysql.sql > dev_mysql.sql
#!/bin/bash

ticket1Number=${1?Numero de ticket #1}
ticket2Number=${2?Numero de ticket #2}
ticket3Number=${3?Numero de ticket #3}
ticket4Number=${4?Numero de ticket #4}
ticket5Number=${5?Numero de ticket #5}

xs="4.1 9.2 18.3"
initial_y=23.5
diff_y=5.5
ticketNumbers="$ticket1Number $ticket2Number $ticket3Number $ticket4Number $ticket5Number"


cat > /tmp/tombola.ps <<EOF
%!PS
/cm { 28.4 mul } bind def
/draft-Bigfont /Courier-Bold findfont 12 scalefont def
gsave initgraphics 0 setgray
draft-Bigfont setfont
EOF

current_y=$initial_y
for ticketNumber in $ticketNumbers
do
  for x in $xs
  do
  cat >> /tmp/tombola.ps <<EOF
newpath
$x cm $current_y cm moveto
($ticketNumber) show
closepath
EOF
  done
  current_y=$(bc <<< "scale=1; $current_y - $diff_y ")
done
cat >> /tmp/tombola.ps <<EOF
showpage
EOF

ps2pdf /tmp/tombola.ps -


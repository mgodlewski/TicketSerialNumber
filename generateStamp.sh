#!/bin/bash

firstTicketNumber=${1?Numero du premier ticket}

xs="3.8 9.2 18.3"
initial_y=23.8
diff_y=5.4

cat > /tmp/tombola.ps <<EOF
%!PS
/cm { 28.4 mul } bind def
/draft-Bigfont /Courier-Bold findfont 12 scalefont def
gsave initgraphics 0 setgray
draft-Bigfont setfont
EOF

for p in $(seq 0 9)
do
current_y=$initial_y
for b in $(seq 0 4)
do
  ticketNumber=$(printf %05d $(($firstTicketNumber + $p + 10 * $b )))
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
echo showpage >> /tmp/tombola.ps
done

ps2pdf /tmp/tombola.ps -


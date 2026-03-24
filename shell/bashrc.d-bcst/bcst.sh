history -s 'export AMS_AUTOJOIN=$(~/bcst/uams/STAT/view_status | sed -nre '"'"'/Current Ex.*/,$s/Index.*Exercise Name ([^,]*),.*/\1/p'"'"' | uniq | fzf -1); echo AMS_AUTOJOIN: $AMS_AUTOJOIN'
history -s 'make -j12 -s clean'
history -s 'sudo crun REL=9999 /opt/AMS2/net/luckyCM/fconfig'
history -s 'hg ci -m "Merges changes from sideshow"'
history -s 'xhost +; sudo -Eu student /opt/AMS2/local/ACES/bin/student_tdf_start_script'
history -s 'xhost +; sudo -Eu instructor /opt/AMS2/local/bin/loginctl'
history -s 'xhost +; sudo -Eu scenario /opt/AMS2/local/bin/loginctl'
history -s 'xhost +; sudo -Eu simdriver /opt/AMS2/local/bin/loginctl'
history -s 'sudo ./install && ant run'
history -s 'sudo ssh console05 /home/chad/bcst/uaces/install'
history -s 'sudo ssh console05 /home/chad/bcst/uams/install'
history -s 'crun -s console04,console05 reinstall_bcst aces'
history -s '/home/chad/bcst/uams/CTL/sc_setup ATP-2_Integrated     4 3 0'
history -s '/home/chad/bcst/uams/CTL/sc_setup ATP-3_Combined       0 2 0'
history -s '/home/chad/bcst/uams/CTL/sc_setup ATP-4_Multi-Combined 0 8 0'
history -a

export PATH=$PATH:/opt/AMS2/local/bin:/opt/AMS2/net/scripts

~/.themes/oomox/change_color.sh -o wallust <(echo -e "\
BG={{foreground | strip}}\
\nBTN_BG={{color15 | strip}}\
\nBTN_FG={{color3  | strip}}\
\nFG={{background | strip}}\
\nGRADIENT=0.0\
\nHDR_BTN_BG={{color6 | strip}}\
\nHDR_BTN_FG={{color15 | strip}}\
\nHDR_BG={{color0 | strip}}\
\nHDR_FG={{color15 | strip}}\
\nROUNDNESS=4\
\nSEL_BG={{color3 | strip}}\
\nSEL_FG={{color15 | strip}}\
\nSPACING=3\
\nTXT_BG={{foreground | strip}}\
\nTXT_FG={{background | strip}}\
\nWM_BORDER_FOCUS={{color2 | strip}}\
\nWM_BORDER_UNFOCUS={{color8 | strip}}\
")


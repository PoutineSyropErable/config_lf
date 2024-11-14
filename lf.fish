function lf
    set -x LF_CD_FILE "/var/tmp/.lfcd-$fish_pid"
    command lf $argv
    if test -s $LF_CD_FILE
        set DIR (realpath (cat $LF_CD_FILE))
        if test $DIR != $PWD
			#echo "cd to $DIR"
            cd $DIR
        end
        rm $LF_CD_FILE
    end
    set -e LF_CD_FILE
end

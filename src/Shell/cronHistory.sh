cron_history() {

  local cronLog='/var/log/syslog'
  local numberOfLines='50'

  # Month, Day, Time, Hostname, tag, user,

  result=$(grep -m $numberOfLines CRON $cronLog \
    | awk '{ s = ""; for (i = 6; i <= NF; i++) s = s $i " "; \
        print "{\"time\" : \"" $1" "$2" "$3 "\"," \
            "\"user\" : \"" $6 "\"," \
            "\"message\" : \"" $5" "gensub("\"", "\\\\\"", "g", s) "\"" \
          "},"
        }'
    )

  echo [${result%?}]
}


cron_history
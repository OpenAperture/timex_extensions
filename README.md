# OpenAperture.Timex.Extensions

This reusable Elixir library contains logic extending the Timex modules.

* get_elapased_timestamp
  * Method to evaluate the elapsed time (against now) and convert to a human-readable string.

* date_from_unix_timestamp
  * Method to convert a Unix timestamp (Integer) into a Timex.Date struct

* time_from_unix_timestamp
  * Method to convert a Unix timestamp (Integer) into a Timex.Time struct

* unix_timestamp_to_gregorian_seconds
  * Method to convert a unix timestamp into Gregorian calendar seconds
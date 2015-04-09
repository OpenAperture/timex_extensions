# OpenAperture.Timex.Extensions

[![Build Status](https://semaphoreci.com/api/v1/projects/46c93fd1-1940-4c81-a861-609300876053/394912/badge.svg)](https://semaphoreci.com/perceptive/timex_extensions)

This reusable Elixir library contains logic extending the Timex modules.

* get_elapased_timestamp
  * Method to evaluate the elapsed time (against now) and convert to a human-readable string.

* date_from_unix_timestamp
  * Method to convert a Unix timestamp (Integer) into a Timex.Date struct

* time_from_unix_timestamp
  * Method to convert a Unix timestamp (Integer) into a Timex.Time struct

* unix_timestamp_to_gregorian_seconds
  * Method to convert a unix timestamp into Gregorian calendar seconds
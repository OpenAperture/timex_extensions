#
# == timex_extensions.ex
#
# This module contains logic extending the Timex modules (https://github.com/bitwalker/timex)
#
defmodule OpenAperture.Timex.Extensions do
 use Timex

  @doc """
  Method to evaluate the elapsed time (against now) and convert to a human-readable string.

  ## Options

  The `start_time` option was the starting Timex.Time struct

  ## Return Values

  String containing the timestamp
  """
  @spec get_elapsed_timestamp(term) :: String.t
  def get_elapsed_timestamp(nil), do: "<unknown>"
  def get_elapsed_timestamp(start_time) do
    timestamp_secs = Time.elapsed(start_time, :secs)
    if (timestamp_secs < 0) do #time will be negative if in the future
      timestamp_secs = timestamp_secs * -1
    end

    if (timestamp_secs < 60) do
      "#{round timestamp_secs} second(s)"
    else
      timestamp_mins = Time.elapsed(start_time, :mins)
      if (timestamp_mins < 0) do #time will be negative if in the future
        timestamp_mins = timestamp_mins * -1
      end

      if (timestamp_mins < 60) do
        "#{round timestamp_mins} minute(s)"
      else
        timestamp_hours = Time.elapsed(start_time, :hours)
        if (timestamp_hours < 0) do #time will be negative if in the future
          timestamp_hours = timestamp_hours * -1
        end

        if (timestamp_hours < 24) do
          "#{round timestamp_hours} hour(s)"
        else
          timestamp_days = Time.elapsed(start_time, :days)
          if (timestamp_days < 0) do #time will be negative if in the future
            timestamp_days = timestamp_days * -1
          end

          if (timestamp_days < 7) do
            "#{round timestamp_days} day(s)"
          else
            timestamp_weeks = Time.elapsed(start_time, :weeks)
            if (timestamp_weeks < 0) do #time will be negative if in the future
              timestamp_weeks = timestamp_weeks * -1
            end

            "#{round timestamp_weeks} week(s)"
          end
        end
      end
    end
  end

  @doc """
  Method to convert a Unix timestamp (Integer) into a Timex.Date struct
  https://github.com/bitwalker/timex/blob/master/lib/date/date.ex

  ## Options

  The `timestamp` options is an Integer unix timestamp (http://en.wikipedia.org/wiki/Unix_time)

  ## Return Values

  Timex.Date struct
  """
  def date_from_unix_timestamp(timestamp) do
    gregorian_seconds = unix_timestamp_to_gregorian_seconds(timestamp)
    Date.add(Date.now(), seconds_to_time(gregorian_seconds))
  end

  @doc """
  Method to convert a Unix timestamp (Integer) into a Timex.Time struct
  https://github.com/bitwalker/timex/blob/master/lib/time/time.ex

  ## Options

  The `timestamp` options is an Integer unix timestamp (http://en.wikipedia.org/wiki/Unix_time)

  ## Return Values

  Timex.Time struct
  """
  def time_from_unix_timestamp(timestamp) do
    gregorian_seconds = unix_timestamp_to_gregorian_seconds(timestamp)
    Time.add(Time.now(), seconds_to_time(gregorian_seconds))
  end

  @doc """
  As suggested here (http://erlang.2086793.n4.nabble.com/Working-with-dates-td2097402.html), method
  to convert a unix timestamp into Gregorian calendar seconds

  ## Options

  The `timestamp` options is an Integer unix timestamp (http://en.wikipedia.org/wiki/Unix_time)

  ## Return Values

  The # of Gregorian seconds (http://www.erlang.org/doc/man/calendar.html#datetime_to_gregorian_seconds-1) - seconds from epoch
  """
  def unix_timestamp_to_gregorian_seconds(timestamp) do
    {days, {hours, minutes, seconds}} = :calendar.seconds_to_daystime( timestamp )
    date = :calendar.gregorian_days_to_date( days )
    :calendar.datetime_to_gregorian_seconds( {date, {hours, minutes, seconds}} )
  end

  #Copy of non-exported method Timex.Time.from(value, :secs) - https://github.com/bitwalker/timex/blob/master/lib/time/time.ex#L76
  def seconds_to_time(value) do
    { sec, micro } = mdivmod(value)
    { mega, sec }  = mdivmod(sec)
    { mega, sec, micro }
  end

  #https://github.com/bitwalker/timex/blob/master/lib/time/time.ex#L280
  defp divmod(a, b) do
    { div(a, b), rem(a, b) }
  end

  #https://github.com/bitwalker/timex/blob/master/lib/time/time.ex#L288
  defp mdivmod(a) do
    divmod(a, 1_000_000)
  end
end

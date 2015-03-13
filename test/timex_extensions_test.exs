require Timex.Time

defmodule CloudOS.Timex.ExtensionsTest do
  use ExUnit.Case
  use Timex

  alias CloudOS.Timex.Extensions

  test "convert to date" do
  	date = Extensions.date_from_unix_timestamp(1415813100)
    assert date != nil
  end

  test "convert to time" do
  	time = Extensions.time_from_unix_timestamp(1415813100)
    assert time != nil
  end  

  test "test timestamp nil" do
    assert Extensions.get_elapased_timestamp(nil) == "<unknown>"
  end   

  test "test timestamp in seconds" do
    now = Time.now()
    then = Time.sub(now, {0,30,0})
    assert Extensions.get_elapased_timestamp(then) == "30 second(s)"
  end  

  test "test timestamp in minutes" do
    now = Time.now()
    then = Time.sub(now, {0,60,0})
    assert Extensions.get_elapased_timestamp(then) == "1 minute(s)"
  end

  test "test timestamp in hours" do
    now = Time.now()
    then = Time.sub(now, {0,6000,0})
    assert Extensions.get_elapased_timestamp(then) == "2 hour(s)"
  end

  test "test timestamp in days" do
    now = Time.now()
    then = Time.sub(now, {0,90000,0})
    assert Extensions.get_elapased_timestamp(then) == "1 day(s)"
  end

  test "test timestamp in weeks" do
    now = Time.now()
    then = Time.sub(now, {0,604800,0})
    assert Extensions.get_elapased_timestamp(then) == "1 week(s)"
  end  
end

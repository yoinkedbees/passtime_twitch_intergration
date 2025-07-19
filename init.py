from rcon.source import Client
def run():
    try:
        with Client("ip", "yourport", passwd="yourrconpassword") as client:
               response = client.run('script','twitchHandler("$username", $donationamountnumberdigits, "$message")')
               return response

    except Exception as e:
        return f"RCON error: {e}"
print(run())

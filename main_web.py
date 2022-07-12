from main import main as stats_main
import asyncio
from http.server import BaseHTTPRequestHandler, HTTPServer
import datetime
import threading
import os

last_run = datetime.datetime.utcfromtimestamp(0)
thread = threading.Thread(target=lambda: print("Threading works"))
thread.start()

def run_stats_main():
    asyncio.run(stats_main())

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/":
            self.send_response(404)
            self.end_headers()
            return

        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()

        global last_run
        global thread
        now = datetime.datetime.utcnow()
        if (now - last_run).total_seconds() / 60 >= 23 * 60 and now.hour == 16 and now.min > 10 and now.min < 40:
            self.wfile.write(bytes("Started", "utf-8"))
            thread.join()
            thread = threading.Thread(target=run_stats_main)
            thread.start()
            last_run = now
        else:
            self.wfile.write(bytes("Not yet", "utf-8"))

if __name__ == "__main__":
    webServer = HTTPServer(("0.0.0.0", int(os.environ.get('PORT'))), MyServer)
    print("Server started")

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")

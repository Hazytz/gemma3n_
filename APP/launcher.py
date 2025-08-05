import subprocess, time, sys, os, traceback

# — CONFIG —  
MODEL       = "gemma3n:e2b"         
SERVER_EXE  = "npc_server.exe"     
GAME_EXE    = "Gamme.exe"         
LOG_FILE    = "launcher_error.log"

def log(msg):
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(msg + "\n")

# Resolve paths relative to this script (or the frozen exe)
base_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
server_path = os.path.join(base_dir, SERVER_EXE)
game_path   = os.path.join(base_dir, GAME_EXE)

def safe_run(cmd, **kwargs):
    return subprocess.run(cmd, check=True, **kwargs)

def pull_model():
    log(f"[{time.ctime()}] Pulling model {MODEL}…")
    safe_run(["ollama", "pull", MODEL])
    log(f"[{time.ctime()}] Model pulled.")

def launch_server():
    if not os.path.isfile(server_path):
        raise FileNotFoundError(f"Server exe not found: {server_path}")
    log(f"[{time.ctime()}] Launching server {server_path}")
    return subprocess.Popen([server_path])

def launch_game():
    if not os.path.isfile(game_path):
        raise FileNotFoundError(f"Game exe not found: {game_path}")
    log(f"[{time.ctime()}] Launching game {game_path} (cwd={base_dir})")
    return subprocess.Popen([game_path], cwd=base_dir)

if __name__ == "__main__":
    # clear old log
    if os.path.exists(LOG_FILE):
        os.remove(LOG_FILE)

    try:
        pull_model()
        server_proc = launch_server()

        time.sleep(2)              # give server a moment to start

        game_proc = launch_game()

        # wait on both so script stays alive
        server_proc.wait()
        game_proc.wait()

    except Exception as e:
        log(f"[{time.ctime()}] Launcher encountered a fatal error: {e}")
        log(traceback.format_exc())
        print(f"Launcher error—see {LOG_FILE}")
        input("Press Enter to exit.")
    else:
        log(f"[{time.ctime()}] Launcher finished cleanly.")
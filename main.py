# commands list



# device
class tcp_device():
    def __init__(self, ip_addr, port) -> None:
        ip_addr = "0.0.0.0"
        port = 1

    def listen(ttl=3):
        try:
            pass
        except:
            pass

    def issue(command, ttl=3):
        try:
            pass
        except:
            pass


class fnip(tcp_device):
    def __init__(self, ip_addr, port) -> None:
        ip_addr = "174.128.0.101"
        port = 7078
        user = "admin"
        passw = "futurenow"

    def set(n):
        return "FN,ON," + str(n) + "\r\n"
    
    def clr(n):
        return "FN,OFF," + str(n) + "\r\n"
    
    def ri():
        return "FN,SRI\r\n"
    
    def ro():
        return "FN,SRE\r\n"
    
    def mode(ch, mode):
        return "FN,MODE," + str(ch) + "," + str(mode) + "\r\n"
    
    class panansonic_pt_rq(tcp_device):
        def __init__(self, ip_addr, port) -> None:
            ip_addr = "174.128.0.102"
            port = 4352
            user = "admin"
            passw = "@Panasonic"

        def on():
            "\x25\x31\x50\x4f\x57\x52\x20\x31\x0d\x0a"

        def off():
            "\x25\x31\x50\x4f\x57\x52\x20\x30\x0d\x0a"
package main
 
import(
  "fmt"
  "net/http"
  "os/exec"
)
 
func requestHandler (w http.ResponseWriter, r *http.Request) {
  cmd := "/bin/hostname"
  out, _ := exec.Command("bash", "-c", cmd).Output()
  fmt.Fprintf(w, "I'm running on %s\n", out)
}
 
func main() {
  http.HandleFunc("/", requestHandler)
  http.ListenAndServe(":80",nil)
}

(ns ericdallo.nrepl-graalvm-sample
  (:require
   [nrepl.core :as nrepl])
  (:gen-class))

(defn ^:private find-dot-nrepl-port-file []
  (try
    (some-> (slurp ".nrepl-port")
            Integer/parseInt)
    (catch Exception _)))

(defn test-eval
  "Tries to connect to a running nrepl server and eval something simple."
  []
  (with-open [conn ^nrepl.transport.FnTransport (nrepl/connect :port ^Integer (find-dot-nrepl-port-file))]
    (-> (nrepl/client conn 5000)
        (nrepl/message {:op "eval" :code "(+ 2 5)"})
        nrepl/response-values)))

(defn -main [& args]
  (try
    (println "Evaluated sucessfully:" (test-eval))
    (catch Exception e
      (println "Error:" e)))
  (System/exit 0))

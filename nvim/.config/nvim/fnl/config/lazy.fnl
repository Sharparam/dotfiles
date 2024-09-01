(let [lazy (require :lazy)]
  (lazy.setup
    {
      :spec [{:import "plugins"}]
      :rocks {:enabled true}}))

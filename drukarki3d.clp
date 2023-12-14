
(deftemplate question
   (slot id)
   (slot text)
   (multislot options))

(deftemplate answer
   (slot id)
   (slot value))

(deftemplate printer
   (slot name))

(defrule start
   =>
   (assert (question (id start) 
                     (text "The thing I want the most is...")
                     (options "Ultra High Print Quality" "Modability" "Ease of Use" "Big Build Volume" "Portability"))))



; Reguła dla wyboru "Ultra High Print Quality"
(defrule ultra-high-print-quality
   ?f <- (answer (id start) (value "Ultra High Print Quality"))
   =>
   (retract ?f)
   (assert (question (id ultra-high-print-quality) 
                     (text "Do you also need affordability?")
                     (options "Yes" "No"))))

; Reguła dla wyboru "Yes" na pytanie o przystępność cenową w kontekście "Ultra High Print Quality"
(defrule ultra-high-print-quality-affordable
   ?f <- (answer (id ultra-high-print-quality) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ultra-high-print-quality-affordable) 
                     (text "Do you need dual extrusion?")
                     (options "Yes" "No"))))

; Reguła dla wyboru "No" na pytanie o przystępność cenową w kontekście "Ultra High Print Quality"
(defrule ultra-high-print-quality-not-affordable
   ?f <- (answer (id ultra-high-print-quality) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Ultimaker2"))))

; Reguły dla wyborów "Yes" i "No" na pytanie o ekstruzję
(defrule ultra-high-print-quality-affordable-extrusion-yes
   ?f <- (answer (id ultra-high-print-quality-affordable) (value "Yes"))
   =>
   (retract ?f)
   (assert (printer (name "Deezmaker Bukobot v2 Duo"))))

(defrule ultra-high-print-quality-affordable-extrusion-no
   ?f <- (answer (id ultra-high-print-quality-affordable) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Deezmaker Bukobot v2"))))




; Dodajemy regułę dla wyboru "Modability"
(defrule modability
   ?f <- (answer (id start) (value "Modability"))
   =>
   (retract ?f)
   (assert (question (id modability) 
                     (text "Do you also need affordability?")
                     (options "Yes" "No"))))

; Reguły dla wyboru "Yes" na pytanie o "Modability"
(defrule modability-affordable
   ?f <- (answer (id modability) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable) 
                     (text "DIY kit or assembled machine?")
                     (options "Kit" "Assembled"))))

(defrule modability-not-affordable
   ?f <- (answer (id modability) (value "No"))
   =>
   (retract ?f)
   (assert (question (id modability-not-affordable) 
                     (text "DIY kit or assembled machine?")
                     (options "Kit" "Assembled"))))

(defrule modability-affordable-kit
   ?f <- (answer (id modability-affordable) (value "Kit"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable-kit) 
                     (text "Would you rather have more build volume or faster printing speeds?")
                     (options "Speed" "Build volume"))))

(defrule modability-affordable-assembled
   ?f <- (answer (id modability-affordable-assembled) (value "Assembled"))
   =>
   (retract ?f)
   (assert (printer (name "Robo3D"))))

(defrule modability-not-affordable-kit
   ?f <- (answer (id modability-not-affordable-kit) (value "Kit"))
   =>
   (retract ?f)
   (assert (printer (name "Lulzbot KITTAZ"))))

(defrule modability-not-affordable-assembled
   ?f <- (answer (id modability-not-affordable-assembled) (value "Assembled"))
   =>
   (retract ?f)
   (assert (printer (name "Lulzbot TAZ 4"))))

(defrule modability-affordable-kit-speed
   ?f <- (answer (id modability-affordable-kit-speed) (value "Speed"))
   =>
   (retract ?f)
   (assert (printer (name "Velleman K8200"))))

(defrule modability-affordable-kit-volume
   ?f <- (answer (id modability-affordable-kit-volume) (value "Build volume"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable-kit-volume) 
                     (text "A little bit more build volume or a LOT more build volume?")
                     (options "A little more" "a LOT more"))))

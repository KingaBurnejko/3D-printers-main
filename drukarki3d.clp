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


;ULTRA HIGH PRINT QUALITY
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
   

;MODABILITY
;Reguła dla wyboru "Modability"
(defrule modability
   ?f <- (answer (id start) (value "Modability"))
   =>
   (retract ?f)
   (assert (question (id modability) 
                     (text "Do you also need affordability?")
                     (options "Yes" "No"))))

; Reguły dla wyboru "Yes" i "No" na pytanie o "Modability"
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

;Reguła dla wyboru "Kit" w przypadku odpowiedzi "Yes" na pytanie o "Affordability"
(defrule modability-affordable-kit
   ?f <- (answer (id modability-affordable) (value "Kit"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable-kit) 
                     (text "Would you rather have more build volume or faster printing speeds?")
                     (options "Speed" "Build volume"))))


;Reguła dla wyboru "Assembled" w przypadku odpowiedzi "Yes" na pytanie o "Affordability"
(defrule modability-affordable-assembled
   ?f <- (answer (id modability-affordable-assembled) (value "Assembled"))
   =>
   (retract ?f)
   (assert (printer (name "Robo3D"))))

;Reguła dla wyboru "Kit" w przypadku odpowiedzi "No" na pytanie o "Affordability"
(defrule modability-not-affordable-kit
   ?f <- (answer (id modability-not-affordable-kit) (value "Kit"))
   =>
   (retract ?f)
   (assert (printer (name "Lulzbot KITTAZ"))))

;Reguła dla wyboru "Assembled" w przypadku odpowiedzi "No" na pytanie o "Affordability"
(defrule modability-not-affordable-assembled
   ?f <- (answer (id modability-not-affordable-assembled) (value "Assembled"))
   =>
   (retract ?f)
   (assert (printer (name "Lulzbot TAZ 4"))))

;Reguła dla wyboru "Speed" w przypadku odpowiedzi "Kit"  
(defrule modability-affordable-kit-speed
   ?f <- (answer (id modability-affordable-kit-speed) (value "Speed"))
   =>
   (retract ?f)
   (assert (printer (name "Velleman K8200"))))

;Reguła dla wyboru "Volume" w przypadku odpowiedzi "Kit"  
(defrule modability-affordable-kit-volume
   ?f <- (answer (id modability-affordable-kit) (value "Build volume"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable-kit-volume) 
                     (text "A little bit more build volume or a LOT more build volume?")
                     (options "A little more" "A LOT more"))))

;Reguła dla wyboru "A little more" w przypadku odpowiedzi "Volume"
(defrule modability-affordable-kit-volume-little-more
   ?f <- (answer (id modability-affordable-kit-volume) (value "A little more"))
   =>
   (retract ?f)
   (assert (question (id modability-affordable-kit-volume-little-more) 
                     (text "Would you rather have better company support or better community support?")
                     (options "Community" "Company"))))
					 
;Reguła dla wyboru "A LOT more" w przypadku odpowiedzi "Volume"
(defrule modability-affordable-kit-volume-lot-more
   ?f <- (answer (id modability-affordable-kit-volume) (value "A LOT more"))
   =>
   (retract ?f)
   (assert (printer (name "Rigidbot Big"))))
   
;Reguła dla wyboru "Community" w przypadku odpowiedzi "A little more"
(defrule modability-affordable-kit-volume-little-more-community
   ?f <- (answer (id modability-affordable-kit-volume-little-more) (value "Community"))
   =>
   (retract ?f)
   (assert (printer (name "Rigidbot Regular"))))
   
;Reguła dla wyboru "Company" w przypadku odpowiedzi "A little more"
(defrule modability-affordable-kit-volume-little-more-company
   ?f <- (answer (id modability-affordable-kit-volume-little-more) (value "Company"))
   =>
   (retract ?f)
   (assert (printer (name "Printrbot Metal Plus"))))
   
   

;EASE OF USE
;Reguła dla wyboru "Ease of use"
(defrule ease-of-use
   ?f <- (answer (id start) (value "Ease of Use"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use) 
                     (text "Do you also need affordability?")
                     (options "Yes" "No"))))
					 
;NOT AFFORDABLE					 
;Reguła dla wyboru "No" na pytanie o "Affortability"
(defrule ease-of-use-not-affordable
   ?f <- (answer (id ease-of-use) (value "No"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-not-affordable) 
                     (text "Are you opposed to the idea of having a MakerBot?")
                     (options "Yes" "No"))))
					 					 
;Reguła dla wyboru "Yes" w przypadku pytania o "MakerBot"
(defrule ease-of-use-not-affordable-maker-bot-clone
   ?f <- (answer (id ease-of-use-not-affordable) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-not-affordable-maker-bot-clone) 
                     (text "How about a MakerBot clone?")
                     (options "That's fine!" "No way!"))))
					 
;Reguła dla wyboru "No" w przypadku pytania o "MakerBot"
(defrule ease-of-use-not-affordable-maker-bot
   ?f <- (answer (id ease-of-use-not-affordable) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Makerbot Replicator 2"))))
   
;Reguła dla wyboru "That's fine!" w przypadku pytania o klona
(defrule ease-of-use-not-affordable-maker-bot-clone-yes
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone) (value "That's fine!"))
   =>
   (retract ?f)
   (assert (printer (name "Flashforge Creator"))))

;Reguła dla wyboru "No way" w przypadku pytania o klona
(defrule ease-of-use-not-affordable-maker-bot-clone-dual-extruder
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone) (value "No way!"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-not-affordable-maker-bot-clone-dual-extruder) 
                     (text "Do you need a dual extruder?")
                     (options "Yes" "No"))))
					 
;DO POPRAWIENIA!
;Reguła dla wyboru "No" w przypadku pytania o "Dual Extruder"
(defrule ease-of-use-not-affordable-maker-bot-clone-not-dual-extruder
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-dual-extruder) (value "No"))
   =>
   (retract ?f)
   (printout t "Make your pick. These three have different build volumes and are priced respectively." crlf)
   (assert (printer (name "SeeMeCNC Orion Delta")) 
		   (printer (name "Airwolf HDX")) 
		   (printer (name "Leapfrog Creator"))))
		   
;Reguła dla wyboru "Yes" w przypadku pytania o "Dual Extruder"
(defrule ease-of-use-not-affordable-maker-bot-clone-triple-extruder
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-dual-extruder) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-not-affordable-maker-bot-clone-triple-extruder) 
                     (text "How does a triple extruder sound?")
                     (options "Cool!" "Eh."))))

;Reguła dla wyboru "Cool!" w przypadku pytania o "Triple Extruder"
(defrule ease-of-use-not-affordable-maker-bot-clone-triple-extruder-yes
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-triple-extruder) (value "Cool!"))
   =>
   (retract ?f)
   (assert (printer (name "3D Systems CubePro Trio"))))
   
;Reguła dla wyboru "Eh." w przypadku pytania o "Triple Extruder"
(defrule ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-triple-extruder) (value "Eh."))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume) 
                     (text "So then just a dual extruder. Do you need a big build volume?")
                     (options "Yes" "No"))))

;Reguła dla wyboru "Yes" w przypadku pytania o "Big build volume"
(defrule ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume-yes
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume) (value "Yes"))
   =>
   (retract ?f)
   (assert (printer (name "Leapfrog Creator XL"))))
   
;Reguła dla wyboru "No" w przypadku pytania o "Big build volume"
(defrule ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume-no
   ?f <- (answer (id ease-of-use-not-affordable-maker-bot-clone-double-extruder-volume) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Leapfrog Creator HS"))))


;AFFORDABLE
;Reguła dla wyboru "Yes" na pytanie o "Affortability"
(defrule ease-of-use-affordable
   ?f <- (answer (id ease-of-use) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-affordable) 
                     (text "Would you rather have more ease of use or more build volume?")
                     (options "Ease of use" "Build volume"))))
					 
;Reguła dla wyboru "Ease of use"
(defrule ease-of-use-affordable-ease-of-use
   ?f <- (answer (id ease-of-use-affordable) (value "Ease of use"))
   =>
   (retract ?f)
   (assert (printer (name "Dremel Ideabuilder"))))
   
;Reguła dla wyboru "Build volume"
(defrule ease-of-use-affordable-volume
   ?f <- (answer (id ease-of-use-affordable) (value "Build volume"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-affordable-volume) 
                     (text "Do you want an open source printer?")
                     (options "Yes" "No/I don't care"))))
					 
;Reguła dla wyboru "Yes" w przypadku pytania o "Open source"
(defrule ease-of-use-affordable-volume-open-source
   ?f <- (answer (id ease-of-use-affordable-volume) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-affordable-volume-open-source) 
                     (text "Do you need a dual extruder?")
                     (options "Yes" "No"))))
					 
;Reguła dla wyboru "No/I don't care" w przypadku pytania o "Open source"
(defrule ease-of-use-affordable-volume-not-open-source
   ?f <- (answer (id ease-of-use-affordable-volume) (value "No/I don't care"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-affordable-volume-not-open-source) 
                     (text "Do you need a dual extruder?")
                     (options "Yes" "No"))))
					 
;Reguła dla wyboru "Yes" na pytanie o "Dual extruder" dla "Open Source"
(defrule ease-of-use-affordable-volume-open-source-dual-extruder
   ?f <- (answer (id ease-of-use-affordable-volume-open-source) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id ease-of-use-affordable-volume-open-source-dual-extruder) 
                     (text "Do you need a big build volume?")
                     (options "Yes" "No"))))

;Reguła dla wyboru "Yes" w pytaniu o "Big build volume"
(defrule ease-of-use-affordable-volume-open-source-dual-extruder-big-volume
   ?f <- (answer (id ease-of-use-affordable-volume-open-source-dual-extruder) (value "Yes"))
   =>
   (retract ?f)
   (assert (printer (name "Solidoodle Workbench"))))
   
;Reguła dla wyboru "No" w pytaniu o "Big build volume"
(defrule ease-of-use-affordable-volume-open-source-dual-extruder-volume
   ?f <- (answer (id ease-of-use-affordable-volume-open-source-dual-extruder) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Solidoodle Workbench Apprentice"))))
					 
;Reguła dla wyboru "No" na pytanie o "Dual extruder" dla "Open Source"		
(defrule ease-of-use-affordable-volume-open-source-not-dual-extruder
   ?f <- (answer (id ease-of-use-affordable-volume-open-source) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Solidoodle 4"))))
   
;Reguła dla wyboru "Yes" na pytanie o "Dual extruder" dla "Not Open Source"	
(defrule ease-of-use-affordable-volume-not-open-source-dual-extruder
   ?f <- (answer (id ease-of-use-affordable-volume-not-open-source) (value "Yes"))
   =>
   (retract ?f)
   (assert (printer (name "XYZPrinting DaVinci 2.0"))))
					 
;Reguła dla wyboru "No" na pytanie o "Dual extruder" dla "Not Open Source"
(defrule ease-of-use-affordable-volume-not-open-source-3d-scanner
   ?f <- (answer (id ease-of-use-affordable-volume-not-open-source) (value "No"))
   =>
   (retract ?f)	
   (assert (question (id ease-of-use-affordable-volume-not-open-source-3d-scanner) 
                     (text "How does a built in 3D scanner sound?")
                     (options "Cool!" "Eh."))))   

;Reguła dla wyboru "Cool!" w pytaniu o "3D Scanner"
(defrule ease-of-use-affordable-volume-not-open-source-3d-scanner-cool
   ?f <- (answer (id ease-of-use-affordable-volume-not-open-source-3d-scanner) (value "Cool!"))
   =>
   (retract ?f)
   (assert (printer (name "XYZPrinting DaVinci 1.0 AiO"))))
   
;Reguła dla wyboru "Eh." w pytaniu o "3D Scanner"
(defrule ease-of-use-affordable-volume-not-open-source-3d-scanner-eh
   ?f <- (answer (id ease-of-use-affordable-volume-not-open-source-3d-scanner) (value "Eh."))
   =>
   (retract ?f)
   (assert (printer (name "XYZPrinting DaVinci 1.0"))))
   

;BIG BUILD VOLUME
;Reguła dla wyboru "Big Build Volume"
(defrule big-build-volume
   ?f <- (answer (id start) (value "Big Build Volume"))
   =>
   (retract ?f)
   (assert (question (id big-build-volume) 
                     (text "Do you also need affordability?")
                     (options "Yes" "No"))))

;NOT AFFORDABLE
;Reguła dla wyboru "No" na pytanie o "Affortability"
(defrule big-build-volume-not-affordable
   ?f <- (answer (id big-build-volume) (value "No"))
   =>
   (retract ?f)
   (assert (question (id big-build-volume-not-affordable) 
                     (text "Are you opposed to the idea of having a MakerBot?")
                     (options "Yes" "No"))))
					 
;Reguła dla wyboru "Yes" na pytanie o "MakerBot"
(defrule big-build-volume-not-affordable-maker-bot
   ?f <- (answer (id big-build-volume-not-affordable) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "Makerbot Replicator Z18"))))
   
;Reguła dla wyboru "No" na pytanie o "MakerBot"
(defrule big-build-volume-not-affordable-not-maker-bot
   ?f <- (answer (id big-build-volume-not-affordable) (value "Yes"))
   =>
   (retract ?f)
   (assert (printer (name "Leapfrog Creator XL"))))


;AFFORDABLE
;Reguła dla wyboru "Yes" na pytanie o "Affortability"	
(defrule big-build-volume-affordable
   ?f <- (answer (id big-build-volume) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id big-build-volume-affordable) 
                     (text "Do you want big build volume, or REALLY BIG build volume?")
                     (options "Big" "REALLY BIG"))))

;Reguła dla wyboru "Big" w pytaniu o "Build volume"
(defrule big-build-volume-affordable-big
   ?f <- (answer (id big-build-volume-affordable) (value "Big"))
   =>
   (retract ?f)
   (assert (printer (name "Rigidbot Big"))))

;Reguła dla wyboru "REALLY BIG" w pytaniu o "Build volume"		
(defrule big-build-volume-affordable-really-big
   ?f <- (answer (id big-build-volume-affordable) (value "REALLY BIG"))
   =>
   (retract ?f)			
   (assert (question (id big-build-volume-affordable-really-big) 
                     (text "DIY kit or assembled machine?")
                     (options "Kit" "Assembled"))))

;Reguła dla wyboru "Kit" 
(defrule big-build-volume-affordable-really-big-kit
   ?f <- (answer (id big-build-volume-affordable-really-big) (value "Kit"))
   =>
   (retract ?f)	
   (assert (printer (name "SeeMeCNC Rostock MAXv2"))))
   
;Reguła dla wyboru "Assembled" 					 
(defrule big-build-volume-affordable-really-big-assembled
   ?f <- (answer (id big-build-volume-affordable-really-big) (value "Assembled"))
   =>
   (retract ?f)	
   (assert (printer (name "Wanhao Duplicator 5"))))
   
   
;PORTABILITY
;Reguła dla wyboru "Portability"
(defrule portability
   ?f <- (answer (id start) (value "Portability"))
   =>
   (retract ?f)
   (assert (question (id portability) 
                     (text "Are you opposed to the idea of having a MakerBot?")
                     (options "Yes" "No"))))

;Reguła dla wyboru "No" w pytaniu o "MakerBot"
(defrule portability-maker-bot
   ?f <- (answer (id portability) (value "No"))
   =>
   (retract ?f)
   (assert (printer (name "MakerBot Replicator Mini"))))
   
;Reguła dla wyboru "Yes" w pytaniu o "MakerBot"
(defrule portability-not-maker-bot
   ?f <- (answer (id portability) (value "Yes"))
   =>
   (retract ?f)
   (assert (question (id portability-not-maker-bot) 
                     (text "What level of portable are we talking about...")
                     (options "Foldable and battery operable" "Lightweight and small"))))
					 
;Reguła dla wyboru "Foldable and battery operable"
(defrule portability-not-maker-bot-foldable
   ?f <- (answer (id portability-not-maker-bot) (value "Foldable and battery operable"))
   =>
   (retract ?f)
   (assert (printer (name "Portabee GO"))))
   
;Reguła dla wyboru "Lightweight and small"
(defrule portability-not-maker-bot-lightweight
   ?f <- (answer (id portability-not-maker-bot) (value "Lightweight and small"))
   =>
   (retract ?f)
   (assert (question (id portability-not-maker-bot-lightweight)
                     (text "Would you rather have the ability to print more materials or have a more portable printer?")
                     (options "More materials" "Portability"))))

;Reguła dla wyboru "More materials"
(defrule portability-not-maker-bot-lightweight-materials
   ?f <- (answer (id portability-not-maker-bot-lightweight) (value "More materials"))
   =>
   (retract ?f)
   (assert (printer (name "Deezmaker Bukito"))))
   
;Reguła dla wyboru "Portability"
(defrule portability-not-maker-bot-lightweight-portability
   ?f <- (answer (id portability-not-maker-bot-lightweight) (value "Portability"))
   =>
   (retract ?f)
   (assert (printer (name "Printrbot Simple Metal"))))					 
					 
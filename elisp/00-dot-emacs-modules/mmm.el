;; ; Handle embedded JavaScript/ECMAScript
;; (when (fboundp 'mmm-mode)
;;   (mmm-add-group
;;    'lzx
;;    '((js-method-cdata
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<method[^>]*>[ \t\n]*<!\\[CDATA\\[[ \t]*\n?"
;;       :back "[ \t]*]]>[ \t\n]*</method>"
;;       :insert ((?j js-tag nil @ "<method language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</method>" @)))

;;      (js-method
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<method[^>]*>[ \t]*\n?"
;;       :back "[ \t]*</method>"
;;       :insert ((?j js-tag nil @ "<method language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</method>" @)))

;;      (js-handler-cdata
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<handler[^>]*>[ \t\n]*<!\\[CDATA\\[[ \t]*\n?"
;;       :back "[ \t]*]]>[ \t\n]*</handler>"
;;       :insert ((?j js-tag nil @ "<handler language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</handler>" @)))

;;      (js-handler
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<handler[^>]*>[ \t]*\n?"
;;       :back "[ \t]*</handler>"
;;       :insert ((?j js-tag nil @ "<handler language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</handler>" @)))

;;      (js-script-cdata
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<script[^>]*>[ \t\n]*<!\\[CDATA\\[[ \t]*\n?"
;;       :back "[ \t]*]]>[ \t\n]*</script>"
;;       :insert ((?j js-tag nil @ "<script language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</script>" @)))

;;      (js-script
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "<script[^>]*>[ \t]*\n?"
;;       :back "[ \t]*</script>"
;;       :insert ((?j js-tag nil @ "<script language=\"JavaScript\">"
;;                    @ "\n" _ "\n" @ "</script>" @)))

;;      (js-inline
;;       :submode ecmascript-mode
;;       :face mmm-code-submode-face
;;       :front "on\w+=\""
;;       :back "\""))))

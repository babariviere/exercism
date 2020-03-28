;;; two-fer.el --- Two-fer Exercise (exercism)

;;; Commentary:

;;; Code:


(provide 'two-fer)

(defun two-fer (&optional name)
  (format "One for %s, one for me." (or name "you")))

;;; two-fer.el ends here

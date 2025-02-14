(use-package elfeed

  :init(setq elfeed-feeds '(
			    "https://fasterthanli.me/index.xml"
			    "https://blog.cleancoder.com/atom.xml"
			    "http://feeds.feedburner.com/martinkl"
			    "https://www.allthingsdistributed.com/atom.xml"
			    "https://jvns.ca/atom.xml"
			    "https://simonwillison.net/atom/everything/"
			    "http://feeds.feedburner.com/ThePragmaticEngineer"
			    "https://feeds.feedburner.com/TheDailyWtf"
			    "https://danluu.com/atom.xml"
			    "https://martinfowler.com/feed.atom"
			    "https://lemire.me/blog/feed/"
			    "https://travisdowns.github.io/feed.xml"
			    ))

  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> l"
    :prefix-command 'Feed
    "l" '("Elfeed" . elfeed)
    "u" '("Elfeed update" . elfeed-update)
    )
  )

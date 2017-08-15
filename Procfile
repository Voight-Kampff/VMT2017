web: bundle exec puma -p $PORT  
worker: QUEUE=* rake environment resque:work
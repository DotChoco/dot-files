# Git
## Git add All
function gta {
  param([object[]]$comment)
  if(!$comment){ git add . }
  else{ git add @($files)}
}

##Git Commit
function gtm {
  param([string]$comment)
  if($comment -eq ""){ $comment = "f: menor update" }
  git commit -m $comment
}

##Git Log
function gtl {
  param([int]$index)
  if($index -eq 0){ git log }
  else { git log -$index }
}

##Fast Commit
function fcm {
  param([string]$comment)
  gta && gtm $comment && gtp
}

function gts { git status }
function gtp { git push }
function gtpl { git pull }



# Git
## Git add All
function gta {
  param([object[]]$files)
  if(!$files){ git add . }
  else{ git add @($files)}
}

##Git Diff
function gtd {
  param(
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$path
  )
  git diff $path
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

##Git Include
function gti {
  param([object[]]$files)
  git update-index --no-assume-unchange $files
}

##Git Exclude
function gte {
  param([object[]]$files)
  git update-index --assume-unchanged $files
}

##Git Restore
function gtr {
  param([object[]]$files)
  git restore $files
}


function gts { git status }
function gtp { git push }
function gtpl { git pull }



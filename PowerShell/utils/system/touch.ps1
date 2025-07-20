function touch {
  param(
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$dir_file,
    [string]$data
  )

  $final_dir = (Get-Location).Path + $dir_file.Substring(1)
  echo($data) >> $dir_file
}


Set-Alias to touch

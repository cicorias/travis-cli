Param(
[Parameter(ValueFromRemainingArguments=$true)]
$remaining)

& docker run -it --rm -v ${PWD}/travis:/root/.travis -v ${PWD}:/data cicorias/travis-cli  $remaining
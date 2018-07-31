urlAddParameter = (url, param, value) => {
  let hash = {};
  let parser = document.createElement('a');
  parser.href = url;
  let parameters = parser.search.split(/\?|&/);
  for (let i = 0; i < parameters.length; i++) {
    if (!parameters[i])
      continue;
    let ary = parameters[i].split('=');
    hash[ary[0]] = ary[1];
  }
  hash[param] = value;
  let list = [];
  Object.keys(hash).forEach(key => {
    list.push(key + '=' + hash[key]);
  });
  parser.search = '?' + list.join('&');
  return parser.href;
}

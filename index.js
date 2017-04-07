const exec = require('child_process').exec
const execute = (script, params) => new Promise((resolve, reject) => {
  exec(`${script} ${params}`, (error, stdout, stderr) => {
    error && reject(String(error))
    resolve(stdout)
  })
})

const blurup = () => (
  execute('./index.sh', process.argv[2]).then(svg =>
    encodeURIComponent(svg)
  ).then(escapedSvg =>
    `url(data:image/svg+xml,${escapedSvg})`
  )
)

blurup()
  .then(console.log)
  .catch(console.error)

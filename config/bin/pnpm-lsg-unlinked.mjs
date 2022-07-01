#!/usr/bin/env node
import { exec } from "child_process"

exec('npm ls --global --json', (err, stdout, stderr) => {
    if (err) throw err

    const deps = JSON.parse(stdout).dependencies
    // dependencies hash looks like:
    // "linked-pkg": { "version": "1.0.0", "resolved": "file:..." },
    // "global-pkg": { "version": "1.0.0" }, ...
    // so we skip any package that has a "resolved" property
    const output = Object.keys(deps).reduce((total, key) => {
        return deps[key].resolved ? total : `${total}${key}\n`
    }, '')

    process.stdout.write(output)
    process.stderr.write(stderr)
})

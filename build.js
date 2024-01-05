const { spawnSync } = require("child_process");
const { copyFileSync } = require("fs");
const changeDirectory = process.chdir;

changeDirectory("packages/org.agera.crypto.workerShared");
run("asconfigc");
copyFileSync("swc/org.agera.crypto.workerShared.swc", "../org.agera.crypto/libs/org.agera.crypto.workerShared.swc");
copyFileSync("swc/org.agera.crypto.workerShared.swc", "../org.agera.crypto.worker/libs/org.agera.crypto.workerShared.swc");
changeDirectory("../org.agera.crypto.worker");
run("asconfigc");
copyFileSync("build/org.agera.crypto.worker.swf", "../org.agera.crypto/src/org.agera.crypto.worker.swf");
changeDirectory("../org.agera.crypto");
run("asconfigc");
copyFileSync("swc/org.agera.crypto.swc", "tests/libs/org.agera.crypto.swc");
changeDirectory("tests");
run("asconfigc");

/**
 * @param {string} object 
 */
function run(command) {
    spawnSync(command, {
        cwd: process.cwd(),
        detached: true,
        stdio: "inherit"
    });
}
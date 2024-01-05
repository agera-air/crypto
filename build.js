const { copyFileSync } = require("fs");
const util = require("util");
const childProcess_exec = util.promisify(require("child_process").exec);
const changeDirectory = process.chdir;

class Main {
    constructor() {
        this.initialize();
    }

    async initialize() {
        changeDirectory("packages/org.agera.crypto.workerShared");
        await this.run("asconfigc");
        copyFileSync("swc/org.agera.crypto.workerShared.swc", "../org.agera.crypto/libs/org.agera.crypto.workerShared.swc");
        copyFileSync("swc/org.agera.crypto.workerShared.swc", "../org.agera.crypto.worker/libs/org.agera.crypto.workerShared.swc");
        changeDirectory("../org.agera.crypto.worker");
        await this.run("asconfigc");
        copyFileSync("build/org.agera.crypto.worker.swf", "../org.agera.crypto/src/org.agera.crypto.worker.swf");
        changeDirectory("../org.agera.crypto");
        await this.run("asconfigc");
        copyFileSync("swc/org.agera.crypto.swc", "tests/libs/org.agera.crypto.swc");
        changeDirectory("tests");
        await this.run("asconfigc");
    }

    /**
     * @param {string} command
     */
    async run(command) {
        try {
            const {stdout, stderr} = await childProcess_exec(command);
            console.log(stdout);
            console.log(stderr);
        } catch (error) {}
    }
}

new Main();
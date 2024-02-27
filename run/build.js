const { copyFileSync } = require("fs");
const util = require("util");
const childProcess_exec = util.promisify(require("child_process").exec);
const changeDirectory = process.chdir;

class Main {
    constructor() {
        this.initialize();
    }

    async initialize() {
        copyFileSync("libs/agera.util.swc", "packages/agera.crypto/libs/agera.util.swc");
        changeDirectory("packages/agera.crypto.bridge");
        await this.run("asconfigc");
        copyFileSync("swc/agera.crypto.bridge.swc", "../agera.crypto/libs/agera.crypto.bridge.swc");
        copyFileSync("swc/agera.crypto.bridge.swc", "../agera.crypto.worker/libs/agera.crypto.bridge.swc");
        changeDirectory("../agera.crypto.worker");
        await this.run("asconfigc");
        copyFileSync("build/agera.crypto.worker.swf", "../agera.crypto/src/agera.crypto.worker.swf");
        changeDirectory("../agera.crypto");
        await this.run("asconfigc");
        copyFileSync("swc/agera.crypto.swc", "../../swc/agera.crypto.swc");
        copyFileSync("swc/agera.crypto.swc", "../../test/libs/agera.crypto.swc");
        copyFileSync("libs/agera.util.swc", "../../test/libs/agera.util.swc");
        if (process.argv[2] == "test") {
            changeDirectory("../../test");
            await this.run("asconfigc");
            await this.run("adl app.xml");
        }
    }

    /**
     * @param {string} command
     */
    async run(command) {
        try {
            const {stdout, stderr} = await childProcess_exec(command);
            console.log(stdout);
            console.log(stderr);
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

new Main();
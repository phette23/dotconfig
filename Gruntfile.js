var path = require('path');

module.exports = function (grunt) {
    'use strict';
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        copy: {
            main: {
                files: [
                    // copy all the dot files but not sudoers-linux
                    // flatten -> put then into ~, not ~/config
                    {
                        expand: true,
                        cwd: 'config',
                        src: [
                            '.*'
                            , '.**/**'
                            , '!sudoers-linux'
                        ],
                        dest: process.env.HOME
                    },
                    {
                        expand: true,
                        src: ['bin/*', '.vim/*'],
                        dest: process.env.HOME
                    },
                    {
                        expand: true,
                        cwd: 'config/emmet',
                        src: ['*.json'],
                        dest: path.join(process.env.HOME, '.config', 'emmet')
                    }
                ]
            }
        },
        watch: {
            main: {
                files: [ 'config/.*', 'bin/*', '.vim/*' ],
                tasks: [ 'copy' ]
            }
        }
    });

    grunt.registerTask('default', ['copy']);
};

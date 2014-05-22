var path = require('path');

module.exports = function (grunt) {
    'use strict';
    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    grunt.initConfig({
        copy: {
            main: {
                files: [
                    // copy all the dot files but not sudoers-linux
                    // flatten -> put then into ~, not ~/config
                    {
                        expand: true,
                        flatten: true,
                        src: ['config/.*'],
                        dest: process.env.HOME
                    },
                    {
                        expand: true,
                        src: ['bin/*'],
                        dest: process.env.HOME
                    }
                ]
            }
        },
        watch: {
            main: {
                files: [ 'config/.*', 'bin/*' ],
                tasks: [ 'copy' ]
            }
        }
    });

    grunt.registerTask('default', ['copy']);
};

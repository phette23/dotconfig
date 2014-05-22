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
                    {
                        expand: true,
                        src: ['config/.*'],
                        dest: process.env.HOME
                    },
                    {
                        expand: true,
                        src: ['bin/*'],
                        dest: path.join(process.env.HOME, 'bin')
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

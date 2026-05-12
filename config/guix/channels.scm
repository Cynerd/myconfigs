(cons* (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         (introduction
           (make-channel-introduction
             "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
             (openpgp-fingerprint
               "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
         (name 'elektroline)
         (url "https://gitlab.com/elektroline-predator/guix-channel.git")
         (introduction
           (make-channel-introduction
             "3fd9ac5fc2fb5b2c77b0fee16163beee419ae353"
             (openpgp-fingerprint
               "981B 17E8 E82C 8C25 4319  3517 DCEF 0A0E 5D03 79F3"))))
       %default-channels)

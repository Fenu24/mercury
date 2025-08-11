#!/usr/bin/env python3
import mercury_library 

def menu():
    print('\nMenu: ')
    print(' 1) Generate big.in')
    print(' 2) Generate clones for batch intergrations')
    print(' 3) Generate clones for batch intergrations and setup run environment')
    print(' 4) Setup run for nominal orbit')
    print(' 0) Exit' ) 
    choice = input('Choose a menu option: ')
    return choice

if __name__ == "__main__":
    print('#############################################')
    print('INTERFACE FOR GENERATING mercury6 INPUT FILES')
    print('#############################################')
    
    while True:
        choice = menu()
        if choice == '1':
            jd_epoch = float(input('Enter JD epoch for planets: '))
            moon_flag = int(input('Include Moon (0 = no / 1 = yes): '))
            if moon_flag != 1 and moon_flag != 0:
                print("ERROR: Unsupported value for Moon inclusion, try 0 or 1")
                exit()
            mercury_library.create_big_mercury(jd_epoch, moon_flag)
            print('File big.in created.\n')
        elif choice == '2':
            nbatch   = int(input('How many batches? '))
            nclo     = int(input('How many clones per batch? '))
            orbfile  = input('NEOCC orbit file path (eq/ke files) or asteroid name (eq0 automatic download): ')
            pla_flag = int(input('Generate big.in: (0 = no / 1 = yes): '))
            if pla_flag != 1 and pla_flag != 0:
                print("ERROR: Unsupported value for planets inclusion, try 0 or 1")
                exit()
            moon_flag = int(input('Include Moon (0 = no / 1 = yes): '))
            if moon_flag != 1 and moon_flag != 0:
                print("ERROR: Unsupported value for Moon inclusion, try 0 or 1")
                exit()

            mercury_library.create_virtual_asteroids_mc(orbfile, nbatch, nclo, pla_flag, moon_flag)
            print('Files small.in created.\n')
        elif choice == '3':
            nbatch   = int(input('How many batches? '))
            nclo     = int(input('How many clones per batch? '))
            orbfile  = input('NEOCC orbit file path (eq/ke files) or asteroid name (eq0 automatic download): ')
            pla_flag = 1
            moon_flag = int(input('Include Moon in the model (0 = no / 1 = yes): '))
            if moon_flag != 1 and moon_flag != 0:
                print("ERROR: Unsupported value for Moon inclusion, try 0 or 1")
                exit()
            set_env = 1
            mercury_library.create_virtual_asteroids_mc(orbfile, nbatch, nclo, pla_flag, moon_flag, set_env)
            print('Files small.in created.\n')
        elif choice == '4':
            orbfile  = input('NEOCC orbit file path (eq/ke files) or asteroid name (eq0 automatic download): ')
            pla_flag = 1
            moon_flag = int(input('Include Moon in the model (0 = no / 1 = yes): '))
            if moon_flag != 1 and moon_flag != 0:
                print("ERROR: Unsupported value for Moon inclusion, try 0 or 1")
                exit()
            set_env = 1
            mercury_library.create_nominal_orbit(orbfile, pla_flag, moon_flag, set_env)
            print('Files small.in created.\n')
        elif choice == '0':
            exit()
        else:
            print('ERROR: Choice ' + choice + ' not valid.')

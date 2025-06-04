#!/usr/bin/env python3
from astroquery.jplhorizons import Horizons
from astroquery.jplhorizons.core import conf
import pandas as pd
import numpy as np
import requests
import os

#################################
##### QUERY FOR THE PLANETS #####
#################################

# Simple mapping of common planets to NAIF IDs
NAIF_IDS = {
    "mercury": "199",
    "venus"  : "299",
    "earth"  : "399",
    "moon"  : "301",
    "earthmoo"  : "3",
    "mars"   : "499",
    "jupiter": "599",
    "saturn" : "699",
    "uranus" : "799",
    "neptune": "899",
}

# Takes orbital elements of Planets by querying the JPL Horizons service
def get_planet_elements(planet_name, jd_epoch):
    conf.verify_ssl = False
    planet_key = planet_name.lower()
    if planet_key not in NAIF_IDS:
        raise ValueError(f"Unsupported planet: {planet_name}. Try one of: {', '.join(NAIF_IDS.keys())}")
    planet_id = NAIF_IDS[planet_key]
    obj = Horizons(id=planet_id, location='500@10', epochs=[jd_epoch])
    elements = obj.elements()
    df = elements.to_pandas()
    elems = [df.loc[0, 'a'], df.loc[0, 'e'], df.loc[0, 'incl'], df.loc[0, 'w'], df.loc[0, 'Omega'], df.loc[0, 'M']]
    return elems

def write_big_file(planets, jd_epoch):
    with open('big.in', 'w') as file:
        # Write the header
        file.write(")O+_06 Big-body initial data  (WARNING: Do not delete this line!!)\n")
        file.write(") Lines beginning with `)' are ignored.\n")
        file.write(")---------------------------------------------------------------------\n")
        file.write(" style (Cartesian, Asteroidal, Cometary) = Asteroidal\n")
        file.write(f" epoch (in days) = {jd_epoch}\n")
        file.write(")------d or D is not matter--0d0 is possible too\n")
        # Loop through planet data and write each planet's data in the required format
        for planet in planets:
            # Extract planet info
            name = planet['name'].upper()
            mass = planet['m']
            radius = planet['r']
            distance = planet['d']
            elems = planet['elems']

            # Write the planet's data with more precision
            file.write(f"{name:<10} m= {mass:.16E}   r= {radius:.6f}D+01 d={distance:.7f}D0\n")
            file.write(f"{elems[0]:.12f} {elems[1]:.14f}   {elems[2]:.10f}\n")
            file.write(f"{elems[3]:.10f} {elems[4]:.10f} {elems[5]:.10f}\n")
            file.write("0.d0 0.d0 0.d0\n")

def create_big_mercury(jd_epoch, moon_flag):
    if moon_flag != 1 and moon_flag != 0:
        print("ERROR: Unsupported value for Moon inclusion, try 0 or 1")
        exit()
    # Set up dictionary for planets
    planets = []
    # Add Mercury
    planet = {
        "name"  : 'mercury',
        "m"     : 0.166013679527193e-06,
        "r"     : 3.00,
        "d"     : 5.4291,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    # Add Venus
    planet = {
        "name"  : 'venus',
        "m"     : 0.244783833966454e-05,
        "r"     : 3.00,
        "d"     : 5.243,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    if moon_flag == 0:
        # Add Earth-Moon barycenter
        planet = {
            "name"  : 'earthmoo',
            "m"     : 0.304043263332660e-05,
            "r"     : 3.00,
            "d"     : 5.52,
            "elems" : [],
        }
        elems = get_planet_elements(planet['name'], jd_epoch)
        planet['elems'] = elems
        planets.append(planet)
    else:
        # Add Earth-Moon barycenter
        planet = {
            "name"  : 'earth',
            "m"     : 0.300348959632e-05,
            "r"     : 3.00,
            "d"     : 5.52,
            "elems" : [],
        }
        elems = get_planet_elements(planet['name'], jd_epoch)
        planet['elems'] = elems
        planets.append(planet)
        # Add Earth-Moon barycenter
        planet = {
            "name"  : 'moon',
            "m"     : 3.69430370066e-08,
            "r"     : 3.00,
            "d"     : 5.52,
            "elems" : [],
        }
        elems = get_planet_elements(planet['name'], jd_epoch)
        planet['elems'] = elems
        planets.append(planet)

    # Add Mars
    planet = {
        "name"  : 'mars',
        "m"     : 0.322715144505386e-06,
        "r"     : 3.00,
        "d"     : 3.9341,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    # Add Jupiter
    planet = {
        "name"  : 'jupiter',
        "m"     : 0.954791938424327e-03,
        "r"     : 3.00,
        "d"     : 1.3262,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    # Add Saturn
    planet = {
        "name"  : 'saturn',
        "m"     : 0.285885980666131e-03,
        "r"     : 3.00,
        "d"     : 0.6871,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    # Add Uranus
    planet = {
        "name"  : 'uranus',
        "m"     : 0.436624404335156e-04,
        "r"     : 3.00,
        "d"     : 1.27,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)

    # Add Neptune
    planet = {
        "name"  : 'neptune',
        "m"     : 0.515138902046611e-04,
        "r"     : 3.00,
        "d"     : 1.638,
        "elems" : [],
    }
    elems = get_planet_elements(planet['name'], jd_epoch)
    planet['elems'] = elems
    planets.append(planet)
    write_big_file(planets, jd_epoch)

#######################################
##### MC BATCHES FOR SMALL BODIES #####
#######################################

def get_orbit(orbit_file):
    # Open orbit file
    cov_el = []
    nor_el = []
    A1 = 0.0
    A2 = 0.0
    with open(orbit_file, 'r') as f:
        for line in f:
            # Search for orbital elements
            if 'EQU' in line or 'KEP' in line:
                # Split the string by whitespace and remove EQU
                orbel = line.split()[1:]
                coord = line.split()[0]
                # Convert the remaining substrings into integers and then into a NumPy array
                x0 = np.array([float(num) for num in orbel], dtype=np.float64)
            # Search for epoch line
            if 'MJD' in line:
                t0 = float(line.split()[1])
            # Search for absolute mag line
            if 'MAG' in line:
                H = float(line.split()[1])
            # Search for least square parameters numbers
            if 'LSP' in line:
                dim = int(line.split()[3])
            # Search for eventual non-gravitational parameters
            if 'NGR' in line:
                A1 = float(line.split()[1])
                A2 = float(line.split()[2])
            if 'COV' in line:
                elements = line.split()[1:]
                for num in elements:
                    cov_el.append(float(num))
            if 'NOR' in line:
                elements = line.split()[1:]
                for num in elements:
                    nor_el.append(float(num))

    # Construct covariance matrix
    # Calculate matrix size
    matrix_size = int((-1 + np.sqrt(1 + 8 * len(cov_el))) / 2)
    # Populate covariance matrix
    cov = np.zeros((matrix_size, matrix_size))
    index = 0
    for i in range(matrix_size):
        for j in range(i, matrix_size):
            cov[i, j] = float(cov_el[index])
            if i != j:
                cov[j, i] = cov[i ,j]
            index += 1

    # Populate normal matrix
    nor = np.zeros((matrix_size, matrix_size))
    index = 0
    for i in range(matrix_size):
        for j in range(i, matrix_size):
            nor[i, j] = float(nor_el[index])
            if i != j:
                nor[j, i] = nor[i ,j]
            index += 1
    # Return the results
    return x0, coord, A1, A2, t0, cov, nor, H, dim

def equ2kep(x):
    a, h, k, p, q, lam = x
    lam = np.deg2rad(lam)
    tgiz = p**2 + q**2
    ecc = np.sqrt(h**2 + k**2)
    inc = 2.0 * np.arctan(np.sqrt(tgiz))
    Omnod = np.arctan2(p, q)
    omega = np.arctan2(h, k) - Omnod
    ell   = lam - omega - Omnod
    inc   = np.rad2deg(inc)
    Omnod = np.rad2deg(np.mod(Omnod, 2*np.pi))
    omega = np.rad2deg(np.mod(omega, 2*np.pi))
    ell   = np.rad2deg(np.mod(ell, 2*np.pi))
    kep = [a, ecc, inc, Omnod, omega, ell]
    return kep

# Here x and cov have the same size
def gen_clone(x0, cov0, coord):
    # Pick a sample of the asteroid orbit
    x = np.random.multivariate_normal(x0, cov0)
    if coord == 'EQU':
       kep_el = equ2kep(x[0:6])
       kep_el.append(x[6:])
    else:
        kep_el = x[0:6]
        kep_el.append(x[6:])
    return kep_el

# x0 is the full nominal orbit, with non-gravs
def create_small_file(nbatch, nclo, x0, t0, cov0, coord):
    # Define the filename
    filename = 'small' + str(nbatch) + '.in'
    with open(filename, 'w') as f:
        # Write header
        f.write(')O+_06 Small-body initial data  (WARNING: Do not delete this line!!)\n')
        f.write(') Lines beginning with ) are ignored.\n')
        f.write(')-----------------------------------------------------\n')
        f.write(' style (Cartesian, Asteroidal, Cometary) = Asteroidal\n')
        f.write(')---------d or D is not matter--0d0 is possible too--\n')
        # Start generating clones and create output
        for j in range(0, nclo):
            clonum  = nclo * (nbatch-1) + j
            cloname = 'clo' + str(clonum) 
            x = gen_clone(x0, cov0, coord)
            # Write the elements in output
            f.write(cloname + '   ep = ' + str(t0) + '\n')
            line = str(x[0]) + " " + str(x[1]) + " " + str(x[2]) + " " + str(x[4]) + " " + str(x[3]) + " " + str(x[5]) + " 0.d0 0.d0 0.d0\n"
            f.write(line)

def create_virtual_asteroids_mc(orbfile, nbatch, nclo, pla_flag, moon_flag, set_env=0):
    # Get asteroid name
    astname = os.path.splitext(os.path.basename(orbfile))[0]
    # Check if orbfile has extension or not
    root, ext = os.path.splitext(orbfile)
    # Initialize the seed
    np.random.seed()

    # Set the environment for integration
    if set_env == 1:
        run_folder = astname
        if os.path.isdir(astname):
            print('ERROR: Folder ' + run_folder + ' already exists. Unable to create run environment.')
            exit()
        else:
            # If orbit is provided in input, read already the orbit file
            if ext: 
                el0, coord, A1, A2, t0, cov, nor, H, npar = get_orbit(orbfile)

            os.mkdir(run_folder)
            os.chdir(run_folder)
            # Create input folder
            os.mkdir('input')
            os.mkdir('output')
            os.symlink('../../python/mercury_batch_run.py', 'mercury_batch_run.py')
            # Change directory to input
            os.chdir('input')
            os.system('cp ../../dat/param.in .')

            # If orbit is read from NEOCC, then download it in input folder and read it
            if not ext:
                print('Downloading eq0 file...')
                orbit_url = f'https://neo.ssa.esa.int/PSDB-portlet/download?file={orbfile}.eq0'
                response = requests.get(orbit_url)
                if response.status_code == 200:
                    astname = orbfile
                    orbfile = orbfile + '.eq0'
                    with open(orbfile, 'w') as f:
                        f.write(response.text)
                    print('Done.')
                    el0, coord, A1, A2, t0, cov, nor, H, npar = get_orbit(orbfile)
                else:
                    print(f"Failed to retrieve data: {response.status_code} - {response.text}")
                    exit()

    # Convert MJD to JD
    t0_JD = t0 + 2400000.5
    # Put eventual non-gravs in the same vector of nominal parameters
    if npar == 6:
        x0 = el0
    elif npar == 7:
        x0 = np.zeros(npar)
        x0[0:6] = el0[0:6]
        if A1 != 0.0:
            x0[6] = A1
        elif A2 != 0.0:
            x0[6] = A2
        else:
            print('ERROR: A1 and A2 are both zeros, but dim = ' + str(npar), err=True)
            exit()
    elif npar == 8:
        x0 = np.zeros(npar)
        x0[0:6] = el0[0:6]
        x0[6] = A1
        x0[7] = A2
    else:
        print('ERROR: dim = ' + str(npar), err=True)
        exit()

    for j in range(0, nbatch):
        create_small_file(j+1, nclo, x0, t0_JD, cov, coord) 

    if pla_flag == 1:
        create_big_mercury(t0_JD, moon_flag)

    if set_env == 1:
        os.chdir('../..')

<script lang="ts">
  import { debugData } from './utils/debugData';
  import { useNuiEvent } from './utils/useNuiEvent';

  import Rental from '$lib/Rental.svelte';
  import Indicator from '$lib/Indicator.svelte';

  let vehicles: any[] = [];
  let showRental: boolean = false;
  let showIndicator: boolean = false;
  let timer = '00:00';
  let seconds = '00';
  let fare = 0;

  useNuiEvent('rent', (data: []) => {
    vehicles = data;
    showRental = true;
  });

  useNuiEvent('hideRental', () =>{
    showRental = false;
  })

  useNuiEvent('indicator', (data: {timer: string, seconds: string, fare: number}) => {
    timer = data.timer;
    seconds = data.seconds
    fare = data.fare;
    showIndicator = true;
  });

  useNuiEvent('hideIndicator', () => {
    showIndicator = false;
    timer = '00:00';
    seconds = '00';
    fare = 0;
  });
  
  debugData([
    {
      action: 'rent',
      data: [
    {
      id: 1,
      name: 'Adder',
      price: 100,
      img: 'https://staticg.sportskeeda.com/editor/2021/06/2d3b2-16242684655025-800.jpg',
      stats: {
        speed: 50,
        acceleration: 60,
        braking: 75,
        handling: 35
      }
    },
    {
      id: 2,
      name: 'Sultan RS',
      price: 200,
      img: 'https://static.wikia.nocookie.net/gtawiki/images/3/34/Sultan-GTAVe-front.png',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 3,
      name: 'Adder',
      price: 100,
      img: 'https://staticg.sportskeeda.com/editor/2021/06/2d3b2-16242684655025-800.jpg',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 4,
      name: 'Sultan RS',
      price: 200,
      img: 'https://static.wikia.nocookie.net/gtawiki/images/3/34/Sultan-GTAVe-front.png',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 5,
      name: 'Adder',
      price: 100,
      img: 'https://staticg.sportskeeda.com/editor/2021/06/2d3b2-16242684655025-800.jpg',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 6,
      name: 'Sultan RS',
      price: 200,
      img: 'https://static.wikia.nocookie.net/gtawiki/images/3/34/Sultan-GTAVe-front.png',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 7,
      name: 'Adder',
      price: 100,
      img: 'https://staticg.sportskeeda.com/editor/2021/06/2d3b2-16242684655025-800.jpg',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 8,
      name: 'Sultan RS',
      price: 200,
      img: 'https://static.wikia.nocookie.net/gtawiki/images/3/34/Sultan-GTAVe-front.png',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
    {
      id: 9,
      name: 'Adder',
      price: 100,
      img: 'https://staticg.sportskeeda.com/editor/2021/06/2d3b2-16242684655025-800.jpg',
      stats: {
        speed: 100,
        acceleration: 100,
        braking: 100,
        handling: 100
      }
    },
      ]
    },
    {
      action: 'indicator',
      data: {
        timer: '05:00',
        fare: 200
      }
    }
  ])
</script>

<main>
  <!-- <VisibilityProvider> -->
    {#if showRental}
      <Rental vehicles={vehicles}/>
    {/if}

    {#if showIndicator}
      <Indicator {timer} {fare} {seconds}/>
    {/if}
  <!-- </VisibilityProvider> -->
</main>

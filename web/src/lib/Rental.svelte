<script lang='ts'>
    import { slide } from 'svelte/transition';
    import { fetchNui } from '../utils/fetchNui';
    
    import Icon from '@iconify/svelte';
    import Card from './Card.svelte';
    
    export let vehicles: any[] = [];

    const onClose = () => {
        fetchNui('hideRental');
    }
</script>

<main>
    <div transition:slide class="rental-container">
        <div class="rental-header">
          <div class="top-container">
            <span class="text-[calc(1.2vh+1.2vw)] font-bold tracking-tight">RENT A VEHICLE</span>
            <button on:click={onClose}>
              <Icon icon="ion:close" color="white" class="bg-[#ff0000] w-[calc(1vh+1vw)] h-[calc(1vh+1vw)] rounded-full p-[20%] hover:bg-red-700 transition-all"/>
            </button>
          </div>
          <span class="text-[calc(0.5vh+0.5vw)] font-medium">Choose the vehicle of your choice</span>
        </div>
        <div class="vehicle-container">
          {#each Object.entries(vehicles) as [model, vehicle]}
            <Card id={model} name={vehicle.name} price={vehicle.price} img={vehicle.img} stats={vehicle.stats}/>
          {/each}
        </div>
    </div>
</main>

<style>
    main{
        display: flex;
        width: 100vw;
        height: 100vh;
        align-items: center;
        background: transparent !important;
    }
    .rental-container{
      border-top: 5px solid #314D94;
      background: #16203C;
      width: 19%;
      height: 50%;
      padding-bottom: 1%;
    }
  .rental-header{
    font-family: Rajdhani;
    color: white;
    display: flex;
    flex-flow: column;
    justify-content: space-between;
    padding: 4%;
    height: 15%;
  }
  span{
    line-height: 100%;
  }
  .top-container{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
  }
  .vehicle-container{
    display: flex;
    flex-flow: row wrap;
    gap: 2%;
    justify-content: center;
    height: 80%;
    margin-top: 5%;
    overflow-y: scroll;
    scroll-snap-type: y mandatory;
  }
  .vehicle-container::-webkit-scrollbar {
    display: none;
  }
</style>
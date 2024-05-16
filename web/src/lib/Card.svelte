<script lang='ts'>
  export let id, name, price, img, stats;
  import Icon from "@iconify/svelte";
  import * as Popover from "$lib/components/ui/popover";
  import { Progress } from "$lib/components/ui/progress";
  import { Label } from "$lib/components/ui/label";
  import { fetchNui } from "../utils/fetchNui";
  import { visibility } from "../store/stores";

  const selectCar = (identifier: string) => {
    fetchNui("selectCar", identifier);
    visibility.set(false);
  }
</script>


<Popover.Root>
  <div class="card-container">
    <img src={img} alt="">
    <div class="card-body">
      <div class="vehicle-details">
        <span class="font-['Inter'] font-bold text-white text-[calc(0.6vh+0.6vw)]">{name}</span>
        <span class="font-['Rajdhani'] font-bold text-green-400 text-[calc(0.6vh+0.6vw)]">${price}<span class="text-[calc(0.4vh+0.4vw)]">/hr</span></span>
      </div>
      <div class="button-cont flex flex-col gap-[5px]">
        <Popover.Trigger><Icon icon="bitcoin-icons:info-filled" class="bg-[#314D94] rounded-full w-[calc(0.7vh+0.7vw)] h-[calc(0.7vh+0.7vw)] p-0.5 transition-all hover:bg-[#2b3d68]"  style="color: white" /></Popover.Trigger>
        <button on:click={() => selectCar(id)}><Icon icon="material-symbols:check" class="bg-[#128510] rounded-full w-[calc(0.7vh+0.7vw)] h-[calc(0.7vh+0.7vw)] p-0.5 transition-all cursor-pointer hover:bg-[#1a5819]" style="color: white" /></button>
      </div>
    </div>
  </div>
  <Popover.Content class="bg-[#213568] outline-none border-0 w-56 mt-1" side="bottom-start">
    <div class="vehicle-specs">
        <Label for="speed">Max Speed:</Label>
        <Progress class="rounded-sm h-1.5" id="speed" value={stats.speed} color="bg-emerald-700"/>
        <Label for="acceleration">Acceleration:</Label>
        <Progress class="rounded-sm h-1.5" id="acceleration" value={stats.acceleration} color="bg-emerald-700"/>
        <Label for="brake">Braking:</Label>
        <Progress class="rounded-sm h-1.5" id="brake" value={stats.braking} color="bg-emerald-700"/>
        <Label for="handling">Handling:</Label>
        <Progress class="rounded-sm h-1.5" id="handling" value={stats.handling} color="bg-emerald-700"/>
    </div>
  </Popover.Content>
</Popover.Root>


<style lang="postcss">
  .card-container{
    scroll-snap-align: start;
    background-color: #1E305E;
    width: 100%;
    height: 100%;
    padding: 7px 7px 0px 7px;
  }
  img{
    width: 100%;
    height: 60%;
    object-fit: cover;
  }
  span{
    line-height: 100%;
  }
  .card-body{
    display: flex;
    height: 40%;
    justify-content: space-between;
    align-items: center;
    padding: 5px 10px 5px 10px;
  }
  .vehicle-details{
    display: flex;
    flex-flow: column;
    gap: 5px;
  }
  .vehicle-specs{
    display: flex;
    flex-flow: column;
    gap: 5px;
    padding: 5px;
    color: white;
  }
</style>
